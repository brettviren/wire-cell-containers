from pathlib import Path
from waflib.Logs import debug, info, error, warn
from waflib.Utils import subst_vars

def options(opt):
    opt.add_option("--owner", default="wirecell",
                   help="Give the 'owner' name used in naming podman images")

def configure(cfg):
    cfg.find_program("podman", var="PODMAN")
    cfg.find_program("singularity", var="SINGULARITY", mandatory=False)


def build_image(task):
    dctx = task.inputs[0].parent
    flag = task.outputs[0]
    cmd = f'${{PODMAN}} build -t {task.generator.image} {dctx}'
    cmd += f' | grep -A2 "Successfully tagged localhost/{task.generator.image}" | tail -1 > {flag}'
#    cmd += f' && echo {task.generator.image} > {flag}'
    cmd = subst_vars(cmd, task.env)
    debug(f'podman: {cmd}')
    return task.exec_command(cmd)

def dump_image(task):
    out = task.outputs[0]
    cmd = f'${{PODMAN}} save --format oci-archive {task.generator.image} -o {out}'
    cmd = subst_vars(cmd, task.env)
    debug(f'podman: {cmd}')
    return task.exec_command(cmd)    


# $ singularity build sluser.sif oci-archive://sluser.tar
    

def build(bld):
    owner = bld.options.owner

    image_deps = dict(
        slscisoft={},
        sluser=dict(deps=("slscisoft",), sing=True),
    )

    for iname, desc in image_deps.items():
        deps = desc.get("deps", ())
        sing = desc.get("sing", False)

        image = f'{owner}/{iname}'
        fname = f'{owner}-{iname}'

        dfile = bld.path.find_resource(f'docker/{iname}/Dockerfile')
        pfile = bld.path.find_or_declare(f'{fname}.podman')
        ffiles = [bld.path.find_or_declare(f'{owner}-{n}.podman') for n in deps]
        debug(f'build: {iname} deps: {ffiles}')
        tfile = bld.path.find_or_declare(f'{fname}.tar')
        sfile = bld.path.find_or_declare(f'{fname}.sif')

        bld(name=f'build-{fname}',
            rule=build_image, image=image,
            source=[dfile] + ffiles, 
            target=pfile)

        if sing and 'SINGULARITY' in bld.env:
            debug(f'build: {iname} dumping to tar and singularity')
            bld(name=f'dump-{fname}',
                rule=dump_image, image=image,
                source=pfile, target=tfile)

            bld(name=f'sing-{fname}',
                rule='${SINGULARITY} build --force ${TGT[0]} oci-archive://${SRC[0]}',
                source=tfile, target=sfile)
            bld.install_files('${PREFIX}/share/containers/singularity', sfile)

    # bld(rule=build_image,
    #     source='docker/slscisoft/Dockerfile',
    #     target='slscisoft.tar')

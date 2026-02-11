# modelsim-docker
An attempt at creating a docker image for modelsim verification

## Structure
The attached docker image is built with the following dockerfile and then installs Modelsim (linux) into `/root/intelFPGA/20.1/modelsim_ase/bin`. Add this to path:

```sh
export PATH=$PATH:/root/intelFPGA/20.1/modelsim_ase/bin
```

## Available Binaries
```
drill      hm_entity  qhdel      qhlib   qhsim     qvhcom  scgenmod   triage   vcover  vdir      vgencomp   vlog   vopt  vsim     wlfman
dumplog64  jobspy     qhdir      qhmake  qrun      qvlcom  sdfcom     vcd2wlf  vdbg    vencrypt  vhencrypt  vmake  vovl  wlf2log  wlfrecover
flps_util  qhcvt      qhgencomp  qhmap   qverilog  sccom   sm_entity  vcom     vdel    verror    vlib       vmap   vrun  wlf2vcd  xml2ucdb
```

This would work well integrated into some Github Action to verify synthesizeability.

## DE1 Toolkit
The DE-1 SoC toolkit 
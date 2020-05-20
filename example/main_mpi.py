#!/usr/bin/env python
#!C:\ProgramData\Anaconda3\python.exe
####################################################################################################################################
####################################################################################################################################
####
####   ParaMonte: plain powerful parallel Monte Carlo library.
####
####   Copyright (C) 2012-present, The Computational Data Science Lab
####
####   This file is part of the ParaMonte library.
####
####   ParaMonte is free software: you can redistribute it and/or modify it
####   under the terms of the GNU Lesser General Public License as published
####   by the Free Software Foundation, version 3 of the License.
####
####   ParaMonte is distributed in the hope that it will be useful,
####   but WITHOUT ANY WARRANTY; without even the implied warranty of
####   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
####   GNU Lesser General Public License for more details.
####
####   You should have received a copy of the GNU Lesser General Public License
####   along with the ParaMonte library. If not, see,
####
####       https://github.com/cdslaborg/paramonte/blob/master/LICENSE
####
####   ACKNOWLEDGMENT
####
####   As per the ParaMonte library license agreement terms,
####   if you use any parts of this library for any purposes,
####   we ask you to acknowledge the use of the ParaMonte library
####   in your work (education/research/industry/development/...)
####   by citing the ParaMonte library as described on this page:
####
####       https://github.com/cdslaborg/paramonte/blob/master/ACKNOWLEDGMENT.md
####
####################################################################################################################################
####################################################################################################################################

import os
import numpy as np
import paramonte as pm
from logfunc import getLogFunc, NDIM

# define a ParaMonte sampler instance

pmpd = pm.ParaDRAM()

pmpd.runSampler ( ndim = NDIM               # number of dimensions of the objective function
                , getLogFunc = getLogFunc   # the objective function: multivariate normal distribution
                , mpiEnabled = True         # flag to request a parallel simulation
                # NOTE: inputFilePath is optional: all simulation specifications can be set as attributes of pmpd.spec
                , inputFilePath = os.path.dirname(os.path.abspath(__file__)) + "/paramonte.in"
                )

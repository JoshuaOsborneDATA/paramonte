%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%
%%%%   MIT License
%%%%
%%%%   ParaMonte: plain powerful parallel Monte Carlo library.
%%%%
%%%%   Copyright (C) 2012-present, The Computational Data Science Lab
%%%%
%%%%   This file is part of the ParaMonte library.
%%%%
%%%%   Permission is hereby granted, free of charge, to any person obtaining a 
%%%%   copy of this software and associated documentation files (the "Software"), 
%%%%   to deal in the Software without restriction, including without limitation 
%%%%   the rights to use, copy, modify, merge, publish, distribute, sublicense, 
%%%%   and/or sell copies of the Software, and to permit persons to whom the 
%%%%   Software is furnished to do so, subject to the following conditions:
%%%%
%%%%   The above copyright notice and this permission notice shall be 
%%%%   included in all copies or substantial portions of the Software.
%%%%
%%%%   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
%%%%   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
%%%%   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
%%%%   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
%%%%   DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
%%%%   OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE 
%%%%   OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
%%%%
%%%%   ACKNOWLEDGMENT
%%%%
%%%%   ParaMonte is an honor-ware and its currency is acknowledgment and citations.
%%%%   As per the ParaMonte library license agreement terms, if you use any parts of 
%%%%   this library for any purposes, kindly acknowledge the use of ParaMonte in your 
%%%%   work (education/research/industry/development/...) by citing the ParaMonte 
%%%%   library as described on this page:
%%%%
%%%%       https://github.com/cdslaborg/paramonte/blob/master/ACKNOWLEDGMENT.md
%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   readSample(file,delimiter)
%
%   Return a list of the contents of a set of ParaMonte simulation(s) output
%   sample files whose names begin the user-provided prefix, specified,
%   by the input simulation specification pmpd.spec.outputFileName.
%
%       WARNING
%
%           This method is to be only used for post-processing of the output
%           chain file(s) of an already finished simulation. It is NOT meant 
%           to be called by all processes in parallel mode, although it is possible.
%
%   Parameters
%   ----------
%
%       file (optional)
%
%           A string representing the path to the chain file with the
%           default value of []. The path only needs to uniquely identify
%           the name of the simulation to which the chain file belongs.
%           For example, specifying "./mydir/mysim" as input will lead to
%           a search for a file that begins with "mysim" and ends with
%           "_chain.txt" inside the directory "./mydir/".
%
%           If there are multiple files with such name, then all of them
%           will be read and returned as a list.
%
%           If this input argument is not provided by the user, the
%           value of the object's `spec` attribute `outputFileName`
%           will be used instead.
%
%           If the specified path is a URL, the file will be downloaded 
%           as a temporary file to the local system and its contents will 
%           be parsed and the file will be subsequently removed.
%
%           If no input is specified via any of the possible routes, 
%           the method will search for any possible candidate file 
%           with the appropriate suffix in the current working directory.
%
%           Example usage:
%
%               pmpd.readSample();
%
%           or,
%
%               pmpd.readSample("./out/test_run_");
%
%           or,
%
%               pmpd.spec.outputFileName = "./out/test_run_";
%               pmpd.readSample();
%
%           The last two of the above examples are equivalent.
%
%       delimiter (optional)
%
%           Optional input string representing the delimiter used in the output
%           sample file. If it is not provided as input argument, the value of
%           the corresponding object's `spec` attribute `outputDelimiter`
%           will be used instead. If none of the two are available,
%           the default comma delimiter "," will be assumed and used.
%
%           Example usage:
%
%               pmpd.readSample("./out/test_run_", " ");
%
%           or,
%
%               pmpd.spec.outputDelimiter = " ";
%               pmpd.readSample("./out/test_run_");
%
%           or,
%
%               pmpd.spec.outputFileName = "./out/test_run_";
%               pmpd.spec.outputDelimiter = " ";
%               pmpd.readSample();
%
%           Both of the above examples are equivalent.
%           The latter is recommended as it is less confusing.
%
%   Returns
%   -------
%
%       sampleList (optional)
%
%           a cell array of objects, each of which corresponds to the contents
%           of a unique sample file. Each object has the following components:
%
%               file
%                   full absolute path to the sample file.
%
%               delimiter
%                   the delimiter used in the sample file.
%
%               ndim
%                   number of dimensions of the domain of the objective function
%                   for which the sample was generated.
%
%               count
%                   the number of unique (weighted) points in the sample file.
%                   This is essentially the number of rows in the sample file
%                   minus one (representing the header line).
%
%               df
%                   the contents of the sample file in the form of
%                   a MATLAB table (df stands for DataFrame).
%
%               dynamic attributes:
%                   corresponding to each column in the sample file, a property
%                   with the same name as the column header is also created
%                   for the object which contains the data stored in that column
%                   of the sample file.
%
%           If no output argument is provided, a sampleList property will be added
%           to the parent sampler-object to which the method readSample() belongs.
%           return value of the method. Otherwise, the list will be stored in a
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function sampleList = readSample(self,file,delimiter)

    if nargin<3; delimiter = []; end
    if nargin<2; file = []; end

    if isempty(self.objectName); self.objectName = inputname(1); end
    callerName = string(mfilename());
    fileType = string(callerName{1}(5:end));
    fileType = string( [ lower(fileType{1}(1)) , fileType{1}(2:end) ] );
    output = fileType + "List";

    if nargout==0
        self.readTabular(callerName,file,delimiter);
    elseif nargout==1
        sampleList = self.readTabular(callerName,file,delimiter);
    else
        self.Err.msg    = "The method, " + self.objectName + "." + callerName + "(file,delimiter)" ...
                        + "optionally outputs one variable (" + output + ") or nothing. If the latter is chosen by the user " ...
                        + "(that is, no output is provivded to the method, " + self.objectName + "." + callerName + "), then the output " + output + ...
                        + " will be instead added as a component of the " + self.object + " object.";
        self.Err.abort();
    end

end

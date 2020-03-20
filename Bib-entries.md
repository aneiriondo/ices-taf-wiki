See also:
[Home](Home),
[Creating a TAF analysis](Creating-a-TAF-analysis),
[Example data records](Example-data-records).

## In this guide

- [General format](#general-format)
- [Source field](#source-field)
- [Model settings](#model-settings)
- [Software version](#software-version)
- [Multiple URLs](#multiple-urls)
- [Dir field](#dir-field)
- [Summary](#summary)

## General format

A metadata file contains one or more entries that use a general BibTeX format:

```
@Type{key,
  field = {value},
  ...,
}
```

Consider, for example, the following metadata entry from a `DATA.bib` file:

```
@Misc{PLE7DFleet_2016.txt,
  originator = {WGNSSK},
  year       = {2016},
  title      = {Survey indices: UK_BTS, FR_GFS, IN_YFS},
  period     = {1987-2015},
  access     = {Public},
  source     = {file},
}
```

Here, a data file is described using the `@Misc` entry type and the string
following the entry type is called a *key*. The next fields state that this file
was prepared by the North Sea working group in 2016, it contains survey indices
from 1987 to 2015, and access to this file is public. It is not necessary to
specify the stock name, since that will be automatically recorded on the TAF
server.

## Source field

The special value `source = {file}` means that the key, in this case
`PLE7DFleet_2016.txt`, is the name of the file located inside
`bootstrap/initial/data`. This file shorthand notation is equivalent to
specifying the relative path: `source = {initial/data/PLE7DFleet_2016.txt}`.

The source field specifies where data or software originate from. The following
types of values can be used in the source field:

1. GitHub reference of the form `owner/repo[/subdir]@ref`, identifying a
   specific version of an R package. A fixed reference such as a tag, release,
   or SHA-1 hash is recommended. Branch names, such as `master`, are pointers
   that are subject to change, and are therefore not reliable as long-term
   references.

2. URL starting with `http` or `https`, identifying a file to download.

3. Relative path starting with `initial`, identifying the location of a file or
   directory provided by the user.

4. Special value `file`, indicating that the metadata key points to a file
   location.

5. Special value `script`, indicating that a bootstrap data script should be run
   to fetch data files from a web service. The metadata key is used both to
   identify the script `bootstrap/key.R` and target directory
   `bootstrap/data/key`.

## Model settings

Model settings can be stored in a file or folder inside `bootstrap/initial/data`
and included as a simple `DATA.bib` entry, for example:

```
@Misc{config,
  originator = {HAWG},
  year       = {2019},
  title      = {Model settings},
  source     = {file},
}
```

## Software version

Another example metadata entry is from a `SOFTWARE.bib` file:

```
@Manual{FLAssess,
  author  = {Laurence T Kell},
  year    = {2018},
  title   = {{FLAssess}: Generic classes and methods for stock assessment
             models},
  version = {2.6.2, released 2018-07-18},
  source  = {flr/FLAssess@v2.6.2},
}
```

This entry describes a specific version of an R package that is required for the
TAF analysis. It is similar, but not identical, to the output from the R command
`citation("FLAssess")`. The *version* field specifies the version number and
release date. When an R package is not an official release but a development
version, the version and source may look like this,

```
  version = {2.6.3, committed 2018-10-09},
  source  = {flr/FLAssess@f1e5acb},
```

or this:

```
  version = {0.5.4 components branch, committed 2018-03-12},
  source  = {fishfollower/SAM/stockassessment@25b3591},
```

For development versions like these, the version number itself may not be
important or accurate, but the branch name and commit date can be informative.
The 7-character SHA reference code is a pointer to the exact version of the
package required for the analysis.

If software entry *A* depends on entry *B*, then *B* should be listed before *A*
in `SOFTWARE.bib`, so they are installed in the right order.

As a final metadata example, we look at a software entry that is not an R
package. It is made available as a directory `sole` containing the model source
code (`sole.tpl`) and executables for different platforms (`sole`, `sole.exe`).
The model does not have an explicit version number, so the version field
contains the year in which the model is used, along with the date when the
source code was last modified:

```
@Article{sole,
  author  = {G. Aarts and J.J. Poos},
  year    = {2009},
  title   = {Comprehensive discard reconstruction and abundance estimation
             using flexible selectivity functions},
  journal = {ICES Journal of Marine Science},
  volume  = {66},
  pages   = {763-771},
  doi     = {10.1093/icesjms/fsp033},
  version = {2016, last modified 2016-04-27},
  source  = {initial/software/sole},
}
```

## Multiple URLs

The source field can specify multiple URLs to download, separated by newlines.
To shorten the source entries, the prefix field can be useful to specify a
prefix that is common for all source entries.

## Dir field

The *dir* field is optional and creates a directory to place files in. If the
dir field is used, it can only have the value `dir = {TRUE}` and the resulting
directory will be named after the metadata key. The dir field is mainly useful
when two or more data files that need to be downloaded have the same name. It is
implied and not necessary to set `dir = TRUE` when `source = {script}` or when
the source field specifies multiple URLs.

## Summary

In summary, the metadata are similar to bibliographic entries, with the
important addition of source directives that guide the bootstrap procedure to
set up data files and software.

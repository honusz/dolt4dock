# dolt4dock

 docker run --rm -ti  --entrypoint /bin/bash -v $PWD/dolt-data:/home/dolt-data -w /home/dolt-data dolt

c7n — Yesterday at 10:04 AM
How does the multiple databases work? Do I need to create each subdirectory and initialize it manually for dolt to use it?
And how does it work when sharing the database? Will each subdatabase require its own repository on dolthub?
Stabs - from PDAP — Yesterday at 10:29 AM
think git
c7n — Yesterday at 10:30 AM
So like submodules?
I got this directory structure atm. Dolt wont start unless /data has been initialized. Doing that the sub directories also does not show up
.
└── data
    ├── dnk
    │   ├── .dolt
    │   └── .tmp
    ├── nok
    │   ├── .dolt
    │   └── .tmp
    ├── swe
    │   ├── .dolt
    │   └── .tmp
    ├── .dolt
    └── .tmp
dnk, nok and swe are all also initialized
This is the config I got. The paths are absolute due to container volume mapping. ./data:/data
...
databases:
  - name: dnk-tokens
    path: /data/dnk
  - name: nok-tokens
    path: /data/nok
  - name: swe-tokens
    path: /data/swe
...
timsehn — Yesterday at 10:43 AM
Dolt is only single database right now
We have ideas for multiple dbs
c7n — Yesterday at 10:45 AM
Ah, so what does the feature --multi-db-dir offer atm?
timsehn — Yesterday at 10:46 AM
So if you dolt init a bunch of dbs
Put them all in a directory
The start a server using multi-db-dir
They all look like different databases
c7n — Yesterday at 10:47 AM
Right, so like I've done atm?
Except I'm defining them in the yaml config instead
timsehn — Yesterday at 10:47 AM
But they all have different commit logs
That works
c7n — Yesterday at 10:48 AM
Sure, so it is very much like git submodules?
timsehn — Yesterday at 10:48 AM
Sort of
c7n — Yesterday at 10:48 AM
I see
timsehn — Yesterday at 10:48 AM
We don’t have a dolt sitting on top
Versioning them together
People use databases differently
Some use them for namespaces
And want the commit log to be shared
c7n — Yesterday at 10:49 AM
Yea, I guess that is sort of what I want too
timsehn — Yesterday at 10:49 AM
Some use them more for isolation
And are ok with separate commit logs
Dolt kind of joins the concept of database and server
c7n — Yesterday at 10:50 AM
And to limit the final size of the database. Each DNK, NOK and SWE database will each be a couple of hundreds GB
timsehn — Yesterday at 10:50 AM
Because you can copy (clone)
c7n — Yesterday at 10:51 AM
And if one only want the DNK database, they don't have to download NOK and SWE
timsehn — Yesterday at 10:51 AM
I get you
Who needs anything but Denmark!
c7n — Yesterday at 10:51 AM
Exactly ::D
So to manage this the best way. DNK, NOK and SWE should each have its own repository on Dolthub, right?
timsehn — Yesterday at 10:52 AM
Yes
Has to be that way
c7n — Yesterday at 10:53 AM
And within my development environment I can somehow "merge" them together or make them appear as a single dolt instance, right?
timsehn — Yesterday at 10:53 AM
That is multi-db-dir
c7n — Yesterday at 10:53 AM
Yes!
Neaty
timsehn — Yesterday at 10:53 AM
When you do that you use use dank
use dnk
Use swe
To switch databases
And standard dnk.table syntax works
If you have not used
Sorry I am mobile
c7n — Yesterday at 10:55 AM
No problem :d
I think I understand how to structure it now
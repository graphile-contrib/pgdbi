# pgdbi roadmap

the current 'modules' of pgdbi are:

- **project**
  - [X] can save a project
  - [X] can import a project
  - [X] can reset tool to default state
  - [ ] potentially add settings and a project page where they are managed
  - [ ] add project name
- **schema explorer**
  - [X] filter to look at only schemas you want
  - [X] look at tables, functions, enums, [ ] and more
  - [X] expose as much info as possible about these items
  - [ ] make sure the schema refresh function works properly with everything
  - [ ] finish the function page
  - [ ] finish the enum page
- **role selector**
  - [X] detects all roles on the current server
  - [X] groups roles into families based on applicable roles
    - [X] this has a bug if lower roles from two families are applicable (which would be bad anyway)
  - [X] user selects roles to use in other tools while building scripts
- **table security**
  - [X] manage desired policies and generate scripts to be included in deployments to true up table security
  - [X] am thinking that the default policy may always be locked to allow no grants.  maybe call it 'null policy'
    - this would ensure that the user would address every table in the project and would not accidentally over-grant privileges
  - *policy templates*
    - [X] define table grants for role families with a check-grid that understands applicable roles
    - [X] enable/disable rls
    - [X] define multiple rls policies with custom name template, using, with check, permissive/restrictive, etc
    - [X] create any number of policy templates
    - [X] default state creates a default policy template with no grants or rls policies
  - *policy assignment*
    - [X] tables start with default policy assigned
    - [X] dialog to assign alternate policy
    - [X] implement in-place customization mode to create a table policy inline
    - [X] a bulk editing tool?
  - *schema security scripts*
    - tabbed by schema, fully realized scripts to apply policies
    - [ ] one script to rule them all mode?
  - [ ] schema security review*
    - [ ] use table grants from graphql to evaluate current db state and flag mis-matches between current and desired policies
- **function security**
  - [X] pretty much the same as table security
- **search tool**
  - [X] using an input term, search all artifacts (tables, functions, columns, indexes, etc)
- **fk index manager**
  - [ ] categorize the state of foreign keys for tables, which allows for certain actions
    - *as_expected* = name correlates to that generated from a mask
      - ack (default, always selected): will not generate any scripting
    - *unexpected_name* = index exists but name is unexpected
      - ack: leave it alone
      - rename: change the name to expected: if there is already an expected index, this one will be...
    - *extra_index* = multiple indexes are defined on a field
      - ack: leave it alone
      - drop: drop it
    - *no_index*
      - ack: leave it alone
      - create: create it
        - [ ] build an interface to create all the different types of indexes (like grants/rls)
  - [ ] build out script realization tools as for other tools

other ideas:

- **plugin support**
  - i am strongly considering refactoring the existing tools such that they are themselves plugins to this tool.  it would be cool to make it easy for the community to extend this in this future.
  - base plugin types that support operations across all tables/functions could simplify the dev process
- **sql executor**
  - there is a placeholder for script execution on some of the tools.  this could also support an ad-hoc sql tool
  - https://github.com/stlbucket/postgraphile-de-extension/blob/master/src/pde/graphile-extensions/execSql.js
    - this is a graphile extension from a previous project exploring a more ambitious IDE concept than for this tool
- **production mode**
  - would obviously have to be bulletproof, but a read-only access via proper authorization would be nice to have
- **graphql vizualizer**
  - incorporate one of the open source tools, or build our own.
- **script generator**
  - https://github.com/stlbucket/postgraphile-de-extension/tree/master/src/pde/graphile-extensions
  - these extensions were the beginnings of something of this nature.  these are just for idea purposes tho
  - could be implemented as a hook with a default implementation
  - default implementation would manage scripts using <a href="https://sqitch.org/">sqitch</a>
    - note: sqitch is just now releasing version 1.0 after like 5 years of community use.  it is a very good tool
  - basically would just generate NEW sqitch packages by wrapping calls to sqitch command line
  - a feature to select a function and automatically set up the rollback properly would be nice
  - maybe other stuff...
- **sqitch visualizer**
  - sqitch provides a rich set of db tables that could easily be exposed in a ui so the state of any installation could be quickly ascertained
- **graphile-migrate visualizer**
  - not sure exactly how this one works, but maybe the best way to migrate postgraphile in the long run?
- **job queue visualizer**
  - if a server is using benjie's job queue, a ui to investigate/manage items could be built
- **community schema library**
  - https://github.com/stlbucket/phile-starter/tree/master/db/release
  - these are some schemas that i intend to use to support a number of projects - only using as an exhibit here
  - what if we had a repository where anyone could publish their own open-source schema for any purpose?
  - then we could build a pgdbi plugin to browse that repo
  - if we also had the script generator, this could be a great way to bootstrap a new project and to deliver tutorials
  - easy install of things like subscriptions, job queue?
  - **smart comments manager**  --  this should really be a different tool but leaving idea here for now
    - build plugin to consume a more rich json structure produced by this tool to replace smart comments if so desired
    - ***big question*** is it possible this tool should operate on the introspection results of the actual server instead of at table level?
    - ***special note*** - instead of 'smart comment', could we call these things schemutators (schema mutators)?
      - they could still be *expressed* as smart comments, but if we build the above plugin, then that kinda goes away
    - build policy templates to help apply common schemutators to all or many tables with an assignment strategy similar to security
      - for instance, you might want all 'created_at' fields to be omitted from create/insert/update mutations on all tables
    - really this is mostly TBD and will involve some more understanding of everything the current smart comments can do


my inspiration for this tool came from repeatedly seeing questions popup in the discord around many of these concepts and others.  also, nobody really likes any of the tools out there.  i had been using pgadmin3 to examine tables/functions/etc, but it is clunky, it hangs the dev process if you have to rebuild the db later, it doesn't work with later postgres versions...  other tools have their own strengths and weaknesses.

but none of them tell you how to build a postgraphile server.  i envision a set of tools that can provide a health check and the scripts to fix issues without all the tedium of writing repeated code for a lot of tables across an application.

the tool should not dictate anything about the dev process around it.  the script generator tool, for example, would need to for sure be extensible to support any other method (migrations).  the fallback method being to copy scripts to clipboard then manually incorporate in a codebase.
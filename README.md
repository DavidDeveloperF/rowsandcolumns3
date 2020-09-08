# rowsandcolumns

Display a matrix made of rows and columns

based on the following video

https://www.youtube.com/watch?v=Fy5KzDwxjlA

Note: at 8mins in I had already made a mistake, by trying to put the for(..) loops
inside _MyHomePageState, when they belong inside Widget build()


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Updated version as I try to integrate with central Github store
version: 1.0.0+3

1.    check out the gitignore file (or files NOT to be store in github)

2.    Log in to Github + create new project (and copy the url:
        https://github.com/DavidDeveloperF/rowsandcolumns.git
      Add url to VCS / Git / Remotes

3.    VCS / Git / Push

        Push master to origin/master was rejected by remote         ?????

4.    suggested soln:
        add new branch  VCS / Git / Branches / new branch
        Push
        then...
        origin/master Rebase

        but Push also rejected      Push NewBranchForGithub to origin/NewBranchForGithub was rejected by remote

5.  Github says 'initialise the repository by adding a readme file'
        created one
        tried Push again....
            - same error

6. Settings - version control / git / github
    setup DavidDeveloperF and password and authenticator token
    Tried again...
    .. same error

7. Tried another way -     VCS / Import from Git / Create repository

    .. same error

8. Actually seems I shoudl be doing it this way....
    VCS / Import to Version Control / Share Project on Github
        >>> ignor wanrgn about already haveing github directotry
      - create new github rowsandcolumns2
    Almost.....

        Successfully created project 'rowsandcolumns2' on GitHub, but initial
        push failed: Enumerating objects: 178, done. Delta compression using up to
        4 threads Total 178 (delta 46), reused 0 (delta 0)
        remote: error: GH007: Your push would publish a private email address.
        remote: You can make your email public or disable this protection by
        visiting: remote: http://github.com/settings/emails failed to push some
        refs to 'https://github.com/DavidDeveloperF/rowsandcolumns2.git'

    Is this is the email address I hard-coded for hard-coded-login - NO - WRONG PROJECT
    19:23	Can't finish GitHub sharing process
    			Successfully created project 'rowsandcolumns2' on GitHub, but initial push failed:
    			Enumerating objects: 178, done.
    			Delta compression using up to 4 threads
    			Total 178 (delta 46), reused 0 (delta 0)
    			remote: error: GH007: Your push would publish a private email address.
    			remote: You can make your email public or disable this protection by visiting:
    			remote: http://github.com/settings/emails
    			failed to push some refs to 'https://github.com/DavidDeveloperF/rowsandcolumns2.git'

    19:31	Pushed NewBranchForGithub to new branch origin/NewBranchForGithub

    I changed my settings on Github, but I don't know what I've actually changed or what shows where.

    WHILE THE FINAL MESSAGE ABOVE DID NOT SHOW ANY ERRORS, i CAN'T SEE ANY FILE ON GITHU

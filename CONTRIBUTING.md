# Contributing to lux

## Code

`lux` isn't an official Exherbo project, but given that it is developed by an
Exherbo developer, and is used by mostly Exherbo users, contributions of code
are accepted through either [GitHub's pull requests][pull-requests], or through
[Exherbo's Gerrit instance][gerrit].

A .gitreview file is in the root of the repository so that you can use Gerrit to
contribute to lux with either [git-review] or [git-gerrit].


If you have multiple features/fixes/things done in one commit, please split them
up into multiple commits, so that they can be reviewed seperately.

## Bugs

Bugs should be reported to [GitHub's issue tracker][issues]. It is recommended
that you read Simon Tatham's excellent article,
["How to Report Bugs Effectively"](reporting-bugs).

[reporting-bugs]:   http://www.chiark.greenend.org.uk/~sgtatham/bugs.html
[gerrit]:           https://galileo.mailstation.de/gerrit
[pull-requests]:    https://github.com/somasis/lux/pulls
[issues]:           https://github.com/somasis/lux/issues
[git-review]:       https://github.com/openstack-infra/git-review
[git-gerrit]:       https://github.com/somasis/git-gerrit

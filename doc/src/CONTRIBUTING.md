# Contribute your code to OddFrames.jl
Have an awesome idea you want to try out? Want to integrate some new ideas
and techniques into OddFrames.jl to make it better? Feel free to fork and try
contributing such. There are a few things you should know about contributing
First of all, whenever you want to make a change, the CHANGELOG.MD here is
pretty easy to comprehend, and somewhat loose fitting. Just describe what
you have done in terms of a full implementation or improving of something.
## Some notes.
First of all, always when you fork, create your development branch from the
**Unstable** branch. If you do not do this, it will make a lot more work for
maintainers to review your pull request, as you could have been writing in a
function that was
dramatically altered between master and Unstable. This package has one release
between breaking versions, starting with 0.1.0. In other words, pushes to master
are going to always be arranged by 0.1.0, 0.1.5, 0.2.0, 0.2.5... and so forth,
incrementing by .5. So please fork **Unstable** instead of **main**.
## Follow the basic methodology.
It should not be hard to contribute code that looks like it belongs in this
package, and there are many approaches one could have. Even if the implementation
is new syntax, given all the different syntax expressions in this library, it
could still belong in this library. However, doing things that do not align
with what is going on at the core here at all could be problematic.
## Thanks
Thanks for considering my concerns with your commits, and how to get your code
pushed to master. Thanks for your contributions. 

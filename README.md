# hachiko

> “Don't just give up, Hachiko.
> Life is about getting knocked down over and over, but still getting up each time.
> If you keep getting up, you win.”
>
> [Nana (manga), by Ai Yazawa](https://en.wikipedia.org/wiki/Nana_(manga))


A **very limited** [Nana](https://github.com/Ruenzuo/nana) memory debugger.

![hachiko.png](hachiko.png)

### Funny story

Go debugging has some limitations. At the time of writing this, Delve expression evaluation is [limited](https://github.com/derekparker/delve/issues/119) which made it specially hard for me to finish Nana. I'm used to dynamic interpreted programming languages so expression evaluation is something I can't live without. Because of this, I created hachiko. This is a dumb Ruby script that takes as input the state transitions of two virtual machines and I can use Ruby dynamic properties to alter this state to easily debug and backtrace problems.

Hey, it served me well.

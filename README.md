# Robot Sweatshop

[![Join the chat at https://gitter.im/JScott/robot_sweatshop](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/JScott/robot_sweatshop?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[Jenkins](http://jenkins-ci.org/) is horrible to maintain and is problematic when automating installation and configuration. [Drone](https://drone.io/) assumes that you use Docker. [Travis-CI](https://travis-ci.org/recent) is difficult to self-host. All of these frameworks are highly opinionated in one way or another, forcing you to do things _their_ way.

Robot Sweatshop is a single-purpose CI server that runs collections of arbitrary scripts when it needs to, usually when new code is pushed. There's no assumptions about what you want to report, what front-end you need, or even what repositories you want to clone because you can do that better than I can. It's just you, your code, and the scripts that test and deploy it.

# Usage

```
gem install robot_sweatshop
sweatshop start
```

Robot Sweatshop uses Eye to handle its services and will set up and configure everything for you.

After configuring a job, POST a payload to `localhost:8080/:format/payload-for/:job`. For example, triggering a Bitbucket Git POST hook on `localhost:8080/bitbucket/payload-for/example` will parse the payload and run the 'example' job with the payload data in the environment.

You can see what jobs are available with `sweatshop job --list`.

Currently supported formats:

- Github (application/json format only)
- Bitbucket

# Configuration

The server isn't much help without a job to run. Run `sudo -E sweatshop job <name>` to create a new job or edit an existing one.

You can also use `sudo -E sweatshop config` to create and edit a user configuration at `/etc/robot_sweatshop/config.yaml`.

Not sure if your job is valid? Run `sweatshop job --inspection <name>` to see if there's something you overlooked.

# Security

_TODO: Support for running as a custom user via eye uid/gid_

# Roadmap

- CLI job running
- Common scrips such as git repo syncing
- Support for multiple workers
- Better logging for the processes
- Improved architecture:

![Improved architecture diagram](http://40.media.tumblr.com/8a5b6ca59c0d93c4ce6fc6b733932a5f/tumblr_nko478zp9N1qh941oo1_1280.jpg)

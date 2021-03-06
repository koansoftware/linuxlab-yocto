# linuxlab-yocto

Setup for the workshop at LinuxLAB 2018
---------------------------------------

Pre-requisites
--------------

The pre-requisites to run this workshop are the following:

 * a PC or Laptop with Linux (preferred), Windows or MacOS.
 * at least 20GB of free space on disk
 * at least 4GB of RAM
 * install Docker following the links below


Introduction
------------
This repo is a helper to create an image that is able to run bitbake/poky.

This is based on CROPS/poky-container [https://github.com/crops/poky-container], so that the output generated in the container will be readable by the user on the host.

The instructions will be slightly different depending on whether Linux, Windows or Mac is used. There are setup instructions for using **Windows/Mac** at https://github.com/crops/docker-win-mac-docs/wiki. When referring to **Windows/Mac** in the rest of the document, it is assumed the instructions at https://github.com/crops/docker-win-mac-docs/wiki were followed.

The preferred/suggested host machine is always **Linux** of course.


Install Docker
--------------
First you need to install and setup docker into your host machine.

* Linux instructions [1] (follow the Post Install instructions [2] (Only the first chapter "Manage Docker as a non-root user") so you can run docker without admin privileges)

    [1] https://docs.docker.com/engine/installation/linux

    [2] https://docs.docker.com/engine/installation/linux/linux-postinstall

* Mac Instructions [3]

    [3] https://github.com/crops/docker-win-mac-docs/wiki/Mac-Instructions

* Windows Instructions [4] (Docker Toolbox)

    [4] https://github.com/crops/docker-win-mac-docs/wiki/Windows-Instructions-%28Docker-Toolbox%29


Running the container
---------------------
Here a very simple but usable scenario for using the container is described.
It is by no means the *only* way to run the container, but is a great starting
point.

* **Create a workdir or volume**
  * **Linux**

    The workdir you create will be used for the output created while using the container.
    For example a user could create a directory using the command below.
  
    ```
    mkdir -p ${HOME}/linuxlab
    ```

    **It is important that you are the owner of the directory.** The owner of the
    directory is what determines the user id used inside the container. If you
    are not the owner of the directory, you may not have access to the files the
    container creates.

    For the rest of the Linux instructions we'll assume the workdir chosen was
    `${USER}/linuxlab`.
    
  * **Windows/Mac**

    On Windows or Mac a workdir isn't needed. Instead the volume called *myvolume* will be used. This volume should have been created when following the instructions at https://github.com/crops/docker-win-mac-docs/wiki.


* **The docker command**
  * **Linux**

    Assuming you used the *workdir* from above, the command
    to run a container for the first time would be:

    ```
    docker run --rm -it -v ${HOME}/linuxlab:/workdir crops/poky --workdir=/workdir
    ```
    
  * **Windows/Mac**
  
    ```
    docker run --rm -it -v myvolume:/workdir crops/poky --workdir=/workdir
    ```

  Let's discuss the options:
  * **_--workdir=/workdir_**: This causes the container to start in the directory
    specified. This can be any directory in the container. The container will also use the uid and gid
    of the workdir as the uid and gid of the user in the container.

  This should put you at a prompt similar to:
  ```
  pokyuser@3bbac563cacd:/workdir$
  ```
  At this point you need to follow the instructions below to setup the Yocto Project environment.


Setup the Yocto Project environment
-----------------------------------

IMPORTANT: before continuing run the docker as described above.

Once you are into the container you should have a prompt similar to:

  ```
  pokyuser@3bbac563cacd:/workdir$
  ```

and now enter the following commands (in the `/workdir` directory)


* **Clone the LinuxLAB project details**

Download the project that provides a preconfigured enviroment and a setup script.

  ```
  cd /workdir
  git clone https://github.com/koansoftware/linuxlab-yocto.git
  ```


Build Yocto Project
-------------------
Execute the script is provided to perform all the required tasks in a single command.

  ```
  /workdir/linuxlab-yocto/setup.sh
  ```

Bitbake will start compiling. It will take about 1 hour, depending on your PC resources.

  ```
  Parsing recipes: 100% |####################################| Time: 0:01:16
  Parsing of 814 .bb files complete (0 cached, 814 parsed). 
        1282 targets, 62 skipped, 0 masked, 0 errors.
  NOTE: Resolving any missing task queue dependencies

  Build Configuration:
  BB_VERSION           = "1.38.0"
  BUILD_SYS            = "x86_64-linux"
  NATIVELSBSTRING      = "ubuntu-16.04"
  TARGET_SYS           = "arm-poky-linux-gnueabi"
  MACHINE              = "qemuarm"
  DISTRO               = "poky"
  DISTRO_VERSION       = "2.5.1"
  TUNE_FEATURES        = "arm armv5 thumb dsp"
  TARGET_FPU           = "soft"
  meta
  meta-poky
  meta-yocto-bsp       = "sumo:091d470a8ae2641040983484609e5cd4dfcf9bfd"
  ```

At this point, after ~1 hour you should have a succesful compilation of your final image.

  ```
  Initialising tasks: 100% |########################################################| Time: 1:05:02
  NOTE: Executing SetScene Tasks
  NOTE: Executing RunQueue Tasks
  NOTE: Tasks Summary: Attempted 2717 tasks of which 2313 didn't need to be rerun and **all succeeded**.
  ```



*Note: The manual instructions are described in https://www.yoctoproject.org/docs/current/yocto-project-qs/yocto-project-qs.html#releases.*

----------

*Copyright (C)2018 Marco Cavallini - KOAN sas, Bergamo - Italia - <http://koansoftware.com>*


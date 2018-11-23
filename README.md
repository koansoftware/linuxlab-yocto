# linuxlab-yocto

Setup for the workshop at LinuxLAB 2018

This repo is a helper to create an image that is able to run bitbake/poky. 
This is based on CROPS/poky-container, so that the output generated in the container will be readable by the user on the host.

The instructions will be slightly different depending on whether Linux, Windows or Mac is used. There are setup instructions for using **Windows/Mac** at https://github.com/crops/docker-win-mac-docs/wiki. When referring to **Windows/Mac** in the rest of the document, it is assumed the instructions at https://github.com/crops/docker-win-mac-docs/wiki were followed.
The preferred/suggested host machine is always **Linux**


Introduction
------------
First you need to install and setup docker into your host machine.

* ** Linux instructions [1] (follow the Post Install instructions [2] so you can run docker without admin privileges)**
 * **[1] https://docs.docker.com/engine/installation/linux**
 * **[2] https://docs.docker.com/engine/installation/linux/linux-postinstall**

* ** Mac Instructions [3]**
 * **[3] https://github.com/crops/docker-win-mac-docs/wiki/Mac-Instructions**

* ** Windows Instructions [4] (Docker Toolbox)**
 * **[4] https://github.com/crops/docker-win-mac-docs/wiki/Windows-Instructions-%28Docker-Toolbox%29**


Running the container
---------------------
Here a very simple but usable scenario for using the container is described.
It is by no means the *only* way to run the container, but is a great starting
point.

* **Create a workdir or volume**
  * **Linux**

    The workdir you create will be used for the output created while using the container.
    For example a user could create a directory using the command
  
    ```
    mkdir -p /home/myuser/linuxlab
    ```

    *It is important that you are the owner of the directory.* The owner of the
    directory is what determines the user id used inside the container. If you
    are not the owner of the directory, you may not have access to the files the
    container creates.

    For the rest of the Linux instructions we'll assume the workdir chosen was
    `/home/myuser/linuxlab`.
    
  * **Windows/Mac**

    On Windows or Mac a workdir isn't needed. Instead the volume called *myvolume* will be used. This volume should have been created when following the instructions at https://github.com/crops/docker-win-mac-docs/wiki.


* **The docker command**
  * **Linux**

    Assuming you used the *workdir* from above, the command
    to run a container for the first time would be:

    ```
    docker run --rm -it -v /home/myuser/linuxlab:/workdir crops/poky --workdir=/workdir
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

IMPORTANT: before continuing run the docker ad described above.

Once you are into the container you should have a prompt similar to:

  ```
  pokyuser@3bbac563cacd:/workdir$
  ```

and now enter the following commands (in the /workdir directory)


* **Clone the LinuxLAB project details**

  ```
  cd /workdir
  git clone git://github.com/koansoftware/linuxlab-yocto
  ```


* **Clone Poky from the Yocto Project**

  ```
  cd /workdir
  git clone git://git.yoctoproject.org/poky -b sumo
  ```

* **Run the first environment setup**

  ```
  cd /workdir/poky
  source oe-init-build-env
  ```

* **Modify the existing default configuration**

  ```
  cd /workdir/poky
  cp linuxlab-yocto/linuxlab-koan-local.conf poky/build/conf/local.conf
  ```

* **Start the first (long) build**

  ```
  cd /workdir/poky
  bitbake core-image-minimal
  ```

At this point, after ~1 hour you should have a succesful compilation of your final image.



* Note: The 'cd' command above is specified constantly in order to avoid mistakes. *

* Note: The instructions above are follwing the commands described in https://www.yoctoproject.org/docs/current/yocto-project-qs/yocto-project-qs.html#releases. *

----------

* Copyright (C)2018 Marco Cavallini - KOAN sas, Bergamo - Italia - <http://koansoftware.com> *


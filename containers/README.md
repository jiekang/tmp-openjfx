```
$ sudo docker build . -t openjfx-builder
$ sudo docker run -it --rm openjfx-builder /bin/bash

$ git clone https://github.com/jiekang/tmp-openjfx.git
$ cd tmp-openjfx
$ scl enable devtoolset-8 bash
$ gradle
```

# container-apache-build
Example of building Apache HTTPd from source within a Linux container

### Example command to build the container:
~~~
   podman build -t example/apache-builder:1 .
~~~

### Example command to run the container:
~~~
   podman run --rm -it -v /tmpdir:/tmp/output:z example/apache-builder:1
~~~
Where `/tmpdir` is a host directory mounted to `/tmp/output` within the container.
The `:z` at the end of the container mount path is for SElinux host systems.

# psuzzi/gitlab-ci-andrust

Docker image with Android SDK, NDK, and Rust tools, to be used in GitLab pipelines


# Make changes and rebuild

Check this section if you want to change the dockerfile, rebuild it and run the image to test it.

Here is how to build and run the image locally

```bash
# build and tag 
docker build -t psuzzi/gitlab-ci-andrust:0.8 .

# run the image and connect with bash
docker run --entrypoint "/bin/bash" -it gitlab-ci-andrust:0.8
```

Once started, you can experiment with bash. 
If you don't provide an entrypoint the container exits immediately because there is no long-running process (i.e. a server). 

# Push to docker hub

When done with the changes, push the image to dockerhub

```bash
docker push psuzzi/gitlab-ci-andrust:0.8
```
# Notes

* The version 29 of android SDK has a bug, solved with `sdkmanager --sdk_root ..`
* For reducing the size of the image, we download images, unzip, and delete the original zip in the same layer (same `RUN` statement)
* `set -eux` traces and stop the pipeline in case any command retursn an exit state value > 0
* Check docker image size: `docker image inspect psuzzi/gitlab-ci-andrust:0.8 --format='{{.Size}}'` (v:0.6 ~5GB, 0.7 ~)


## References

Related information:

* [Dockerfile Reference](https://docs.docker.com/engine/reference/builder/) and [Best Practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
* [RUN commands and deletion on the same layer](https://forums.docker.com/t/why-run-command-which-deletes-files-inflates-image-size/33670)
* [Docker hub](https://docs.docker.com/docker-hub/) main information, 
and [dockerhub openjdk](https://hub.docker.com/_/openjdk/)
* [Android sdkmanager](https://developer.android.com/studio/command-line/sdkmanager), and [how to fix sdkmanager bug](https://stackoverflow.com/questions/60440509/android-command-line-tools-sdkmanager-always-shows-warning-could-not-create-se)
* A few inspiring Dockerfiles: 
[jangrewe/gitlab-ci-android](https://github.com/jangrewe/gitlab-ci-android), 
[lakoo/lakoo-android-ndk](https://github.com/lakoo/lakoo-android-ndk),
[tomaka/rust-android-docker](https://github.com/tomaka/rust-android-docker)
[bitrise-io/android](https://github.com/bitrise-io/android),
[bitrise-io/android-ndk](https://github.com/bitrise-io/android-ndk)
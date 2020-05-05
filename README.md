# psuzzi/gitlab-ci-andrust

Docker image with Android SDK, NDK, and Rust tools, to be used in GitLab pipelines


# Make changes and rebuild

Check this section if you want to change the dockerfile, rebuild it and run the image to test it.

Here is how to build and run the image locally

```bash
# rebuild locally and tag the image
docker build -t psuzzi/gitlab-ci-andrust:0.9 .

# test the image by running bash in the container 
docker run --entrypoint "/bin/bash" -it psuzzi/gitlab-ci-andrust:0.9

# push the locally built image to dockerhub
docker push psuzzi/gitlab-ci-andrust:0.9
```

Once started, you can experiment with bash. 
If you don't provide an entrypoint the container exits immediately because there is no long-running process (i.e. a server). 

# Push to docker hub

When pushing a change to the Dockerfile on the `master` branch, a new image tagged `latest` is pushed to _Docker Hub_.

Alternatively, you can push an image with a specific tag as follows.
```bash
docker push psuzzi/gitlab-ci-andrust:0.8
```


# Notes

* This dockerfile is on Github for its ease of integration with Docker Hub. It will be later moved to Gitlab.
* The version 29 of android SDK has a bug, solved with `sdkmanager --sdk_root ..`
* For reducing the size of the image, we download images, unzip, and delete the original zip in the same layer (same `RUN` statement)
* `set -eux` traces and stop the bash pipeline in case any command retursn an exit state value > 0
* Check docker image size: `docker image inspect psuzzi/gitlab-ci-andrust:0.8 --format='{{.Size}}'` (v:0.6 ~5GB, 0.7 ~)


## References

Related information:

* [Dockerfile Reference](https://docs.docker.com/engine/reference/builder/) and 
[Best Practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
* [RUN commands and deletion on the same layer](https://forums.docker.com/t/why-run-command-which-deletes-files-inflates-image-size/33670)
* [Docker hub](https://docs.docker.com/docker-hub/) main information, 
and [dockerhub openjdk](https://hub.docker.com/_/openjdk/)
* [Android sdkmanager](https://developer.android.com/studio/command-line/sdkmanager), and [how to fix sdkmanager bug](https://stackoverflow.com/questions/60440509/android-command-line-tools-sdkmanager-always-shows-warning-could-not-create-se)
* A few inspiring Dockerfiles: 
[jangrewe/gitlab-ci-android](https://github.com/jangrewe/gitlab-ci-android), 
[lakoo/lakoo-android-ndk](https://github.com/lakoo/lakoo-android-ndk), 
[rust-lang/docker-rust (buster-slim)](https://github.com/rust-lang/docker-rust/blob/deb612dd257e15f2bfe877fd3253b2b1b7c261df/1.43.0/buster/slim/Dockerfile); 
[tomaka/rust-android-docker](https://github.com/tomaka/rust-android-docker), 
[bitrise-io/android](https://github.com/bitrise-io/android), 
[bitrise-io/android-ndk](https://github.com/bitrise-io/android-ndk), 
[nick-petrovsky/docker-android-sdk-ndk](https://github.com/nick-petrovsky/docker-android-sdk-ndk)

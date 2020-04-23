# gitlab-ci-android-rust

Docker image with Android SDK, NDK, and Rust tools, to be used in GitLab pipelines


# Make changes and rebuild

Check this section if you want to change the dockerfile, rebuild it and run the image to test it.

Here is how to build and run the image locally

```bash
# build and tag 
docker build --tag gitlab-ci-andrust:0.6 .

# run the image and connect with bash
docker run --entrypoint "/bin/bash" -it gitlab-ci-andrust:0.6
```
Once started, you can find the container and get a bash shell in it


## References

Here is a list of refs useful to understand the Dockerfile

* [Dockerfile Reference](https://docs.docker.com/engine/reference/builder/)
* [Dockerhub openjdk](https://hub.docker.com/_/openjdk/)
* [Android sdkmanager](https://developer.android.com/studio/command-line/sdkmanager), and [how to fix sdkmanager bug](https://stackoverflow.com/questions/60440509/android-command-line-tools-sdkmanager-always-shows-warning-could-not-create-se)
* A few inspiring Dockerfiles [jangrewe/gitlab-ci-android](https://github.com/jangrewe/gitlab-ci-android), 
[lakoo/lakoo-android-ndk](https://github.com/lakoo/lakoo-android-ndk),
[bitrise-io/android](https://github.com/bitrise-io/android),
[bitrise-io/android-ndk](https://github.com/bitrise-io/android-ndk)
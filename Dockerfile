#
# GitLab CI: AndRust v0.8
# 
# Android SDK, NDK and rust - on top of openjdk:8-jdk (Debian)
#

# https://github.com/docker-library/openjdk/blob/bce2fa373dc270cccf539a8e31b5f2a432d23738/11/jdk/slim/Dockerfile
FROM openjdk:8-jdk
LABEL maintainer="Patrik Suzzi <psuzzi@gmail.com>"

ENV PATH ${PATH}:/root/.cargo/bin

# debian packages
RUN set -eux; \
	apt-get -qq update; \
	apt-get install -qqy --no-install-recommends \
		ca-certificates \
		gcc \
		libc6-dev \
		wget \
		curl \
		locales \
		unzip; \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

RUN mkdir -p /opt/android-sdk-linux && mkdir -p ~/.android && touch ~/.android/repositories.cfg
WORKDIR /opt

ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${PATH}:${ANDROID_HOME}/tools
ENV ANDROID_NDK /opt/android-ndk-linux
ENV ANDROID_NDK_HOME /opt/android-ndk-linux
# ENV SDKMANAGER_OPTS "--add-modules java.se.ee"

RUN locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

# download sdk tools - you might want to update the file from time to time
RUN set -eux; \
	wget -q --output-document=sdk-tools.zip "https://dl.google.com/android/repository/commandlinetools-linux-6200805_latest.zip"; \
	unzip sdk-tools.zip -d "${ANDROID_HOME}"; \
	rm -f sdk-tools.zip

# NOTE: --sdk-root is a workaround for a bug in the sdk manager

# accept licenses before installing components
RUN yes | sdkmanager --sdk_root=${ANDROID_HOME} --licenses

# build-tools-<ver>, and android-<ver> might change over time
RUN sdkmanager --sdk_root=${ANDROID_HOME} \
    "build-tools;29.0.2" \
    "platforms;android-29" \
    "extras;android;m2repository" \
    "extras;google;m2repository" \
    "extras;google;google_play_services" \
    "cmake;3.6.4111459"

# download android ndk (big download) - you might want to update the dl file from time to time
RUN set -eux; \
	wget -q --output-document=android-ndk.zip "https://dl.google.com/android/repository/android-ndk-r21-linux-x86_64.zip"; \
	unzip android-ndk.zip; \
	rm -f android-ndk.zip; \
	mv android-ndk-r21 "${ANDROID_NDK_HOME}"

 # install rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
# install rust packages 
RUN set -eux; \
	cargo install cbindgen; \
	# ios architectures
	rustup target add x86_64-apple-ios; \
	rustup target add aarch64-apple-ios; \
	# android arches
	rustup target add arm-linux-androideabi; \
	rustup target add aarch64-linux-android; \
	rustup target add x86_64-linux-android; \
	rustup target add i686-linux-android
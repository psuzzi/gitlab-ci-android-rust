#
# GitLab CI: AndRust v0.6
#

FROM openjdk:9-jdk
MAINTAINER Patrik Suzzi <psuzzi@gmail.com>

RUN mkdir -p /opt/android-sdk-linux && mkdir -p ~/.android && touch ~/.android/repositories.cfg
WORKDIR /opt

ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${PATH}:${ANDROID_HOME}/tools
ENV ANDROID_NDK /opt/android-ndk-linux
ENV ANDROID_NDK_HOME /opt/android-ndk-linux
ENV SDKMANAGER_OPTS "--add-modules java.se.ee"

ENV ANDROID_SDK_TOOLS_ARCHIVE "commandlinetools-linux-6200805_latest"
ENV ANDROID_BUILD_TOOLS "29.0.2"
ENV ANDROID_COMPILE_SDK "29"
#ENV ANDROID_NDK_ARCHIVE: "android-ndk-r21-linux-x86_64"

# install some software
RUN apt-get -qq update \
 && apt-get install -qqy --no-install-recommends \
	unzip \
	wget \
	locales

RUN locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

# download sdk tools
RUN wget -q --output-document=sdk-tools.zip https://dl.google.com/android/repository/${ANDROID_SDK_TOOLS_ARCHIVE}.zip
RUN unzip sdk-tools.zip -d ${ANDROID_HOME} 
RUN	rm -f sdk-tools.zip

# accept licenses before installing components
RUN yes | sdkmanager --sdk_root=${ANDROID_HOME} --licenses

#	--sdk-root is a workaround for a bug in the sdk manager
RUN sdkmanager --sdk_root=${ANDROID_HOME} \
    "build-tools;${ANDROID_BUILD_TOOLS}" \
    "platforms;android-${ANDROID_COMPILE_SDK}" \
    "extras;android;m2repository" \
    "extras;google;m2repository" \
    "extras;google;google_play_services" \
    "cmake;3.6.4111459"

# download android ndk (big download)
RUN wget -q --output-document=android-ndk.zip "https://dl.google.com/android/repository/${ANDROID_NDK_ARCHIVE}.zip" && \
	unzip android-ndk.zip -d android-ndk-linux && \
	rm -f android-ndk.zip && \
	mv android-ndk-r21 android-ndk-linux


FROM ubuntu:22.10 AS builder

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /tmp

# install requirements to obtain/install streamripper
RUN apt update && apt install -qy wget gcc libglib2.0-dev make

# cleanup
RUN apt autoclean && apt autoremove -qy && apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
	/usr/share/man /usr/share/groff /usr/share/info \
	/usr/share/lintian /usr/share/linda /var/cache/man && \
	(( find /usr/share/doc -depth -type f ! -name copyright|xargs rm || true )) && \
	(( find /usr/share/doc -empty|xargs rmdir || true ))

# obtain streamripper
RUN wget -O streamripper.tar.gz \
	https://sourceforge.net/projects/streamripper/files/streamripper%20%28current%29/1.64.6/streamripper-1.64.6.tar.gz/download \
	&& tar -zxf streamripper.tar.gz && \
	rm -rf streamripper.tar.gz

# build streamripper
RUN cd streamripper* && \
	./configure && \
	make && \
	cp streamripper /tmp/streamripper


FROM ubuntu:22.10

ENV DEBIAN_FRONTEND=noninteractive

COPY --from=builder /tmp/streamripper /usr/local/bin/streamripper

# install just glib
RUN apt update && apt install -qy libglib2.0-dev

# cleanup
RUN apt autoclean && apt autoremove -qy && apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
	/usr/share/man /usr/share/groff /usr/share/info \
	/usr/share/lintian /usr/share/linda /var/cache/man && \
	(( find /usr/share/doc -depth -type f ! -name copyright|xargs rm || true )) && \
	(( find /usr/share/doc -empty|xargs rmdir || true ))

# create abc user and make folders
RUN useradd -u 911 -U -d /config -s /bin/bash abc && \
	usermod -G users abc && \
	mkdir -p /songs /ripper

WORKDIR /ripper

COPY entrypoint.sh /scripts/entrypoint.sh

COPY rip.sh /scripts/rip.sh

RUN chmod +x /scripts/entrypoint.sh /scripts/rip.sh

ENTRYPOINT ["/bin/bash", "-c", "exec /scripts/entrypoint.sh"]


# Using alpine
FROM alpine as builder

# Installing required packages
RUN \
  apk add build-base

# Create folder for source codes
RUN mkdir /root/src \
  && mkdir /data

# Copy and compile str2str and convbin (RTKLIB)
COPY myRTKLIB /root/src/rtklib

RUN cd /root/src/rtklib/consapp/str2str/gcc \
  && make \
  && make install \
  && cd

RUN cd /root/src/rtklib/consapp/convbin/gcc \
  && make \
  && make install \
  && cd
  
# Copy and compile rnxcmp
COPY rnxcmp/source/ /root/src/rnxcmp
RUN cd /root/src/rnxcmp \
  && gcc -ansi -O2 -static rnx2crx.c -o RNX2CRX \
  && gcc -ansi -O2 -static crx2rnx.c -o CRX2RNX \
  && cp RNX2CRX /usr/local/bin/RNX2CRX \
  && cp CRX2RNX /usr/local/bin/CRX2RNX

# Make the binaries executable
RUN chmod +x /usr/local/bin/*

# Using alpine
FROM alpine as application

# Copy compiled binaries
#COPY --from=builder /usr/local/bin/convbin /usr/local/bin/
#COPY --from=builder /usr/local/bin/RNX2CRX /usr/local/bin/
# Copy scripts and crontab file
COPY root /root/
#COPY conf /root/conf

# Make the binaries executable
# Configure crontab
RUN chmod +x /root/bin/* \
  && cp -p /root/conf/cronfile.txt /etc/crontabs/cronfile \
  && chmod 0644 /etc/crontabs/cronfile \
  && crontab /etc/crontabs/cronfile
COPY --from=builder /usr/local/bin/str2str /usr/local/bin/convbin /usr/local/bin/RNX2CRX /usr/local/bin/

# Start main script (crond and str2str)
CMD ["/root/bin/logrcvr"]    

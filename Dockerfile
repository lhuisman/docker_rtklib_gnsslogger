# Using alpine
FROM alpine as builder

# Installing required packages
RUN \
  apk add \
      tzdata \
      build-base

#set time zone and start ntp
RUN ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime
    
# Create folder for source codes
RUN mkdir /root/src \
  && mkdir /data

# Copy and compile str2str and convbin (RTKLIB)
COPY myRTKLIB /root/src/rtklib

RUN cd /root/src/rtklib/app/str2str/gcc \
  && make \
  && make install \
  && cd

RUN cd /root/src/rtklib/app/convbin/gcc \
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


# Using alpine
FROM alpine as application

# Copy compiled binaries
COPY --from=builder /usr/local/bin/str2str /usr/local/bin/
COPY --from=builder /usr/local/bin/convbin /usr/local/bin/
COPY --from=builder /usr/local/bin/RNX2CRX /usr/local/bin/

# Make the binaries executable
RUN chmod +x /usr/local/bin/* 

# Copy scripts and crontab file
COPY bin /root/bin
COPY conf /root/conf
RUN chmod +x /root/bin/* 

# Configure crontab
RUN cp -p /root/conf/cronfile.txt /etc/crontabs/cronfile
RUN chmod 0644 /etc/crontabs/cronfile
RUN crontab /etc/crontabs/cronfile

# Start main script (crond and str2str)
CMD ["/root/bin/logrcvr"]    

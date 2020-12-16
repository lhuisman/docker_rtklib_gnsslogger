# docker_rtklib_gnsslogger
A docker repository to log data form a GNSS receiver using RTKLIB str2str tool and convert in to Hatanaka compressed RINEX using RTKLIB convbin and RNXCMP crx2rnx.  

## Configuration using Environment file
See ublox.env and rtcm3.env for an example

## Docker commands
- Building: docker build --rm -t geopinie/gnsslogger ./
- Starting the image: docker run --name gnsslogger -d --restart=always -m="128m" --memory-swap="128m" --cpus=".25" -t --env-file ublox.env --device /dev/ttyAMA0:/dev/ublox -v /data/gnsslogger/:/data geopinie/gnsslogger
  
- Building for Rapsberry Pi on other platform: docker build --platform arm64 --rm -t geopinie/gnssloggerpi ./
- Saving the image: docker save geopinie/gnssloggerpi:latest > gnssloggerpi.tar
- Importing tar file on the Raspberry Pi: docker load -i gnssloggerpi.tar


FROM ubuntu

ENV FLYWHEEL=/flywheel/v0
WORKDIR ${FLYWHEEL}

ENV PATH=${FLYWHEEL}/flywheel/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV PYTHONPATH=${FLYWHEEL}/flywheel/lib

RUN apt update
RUN apt full-upgrade -y
RUN apt install -y					\
			autoconf			\
			bc				\
			build-essential			\
			csvkit				\
			gcc-12				\
			g++-12				\
			git				\
			jq				\
			libopenblas-dev			\
			libtool				\
			libcrypt-dev			\
			libxt6				\
			vim				\
			wget

RUN   CONTREPO=https://repo.continuum.io/archive   	     ; \
      ANACONDAURL=$(wget -q -O - $CONTREPO index.html | grep "Anaconda3-" | grep "Linux" | grep "86_64" | head -n 1 | cut -d \" -f 2)				        ; \
      mkdir ~/Downloads	       	 	   	      	     ; \
      wget -O ~/Downloads/anaconda.sh "${CONTREPO}/${ANACONDAURL}"  ; \
      bash ~/Downloads/anaconda.sh -b -p $HOME/anaconda3

RUN   ~/anaconda3/bin/conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main
RUN   ~/anaconda3/bin/conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r
COPY  defaultenv.yaml ${FLYWHEEL}/defaultenv.yaml
RUN   ~/anaconda3/bin/conda env create -f ${FLYWHEEL}/defaultenv.yaml
RUN   ~/anaconda3/bin/conda init

#RUN   bash -c '~/anaconda3/bin/conda activate AlohaEnv; CC=gcc-12 CXX=g++-12 CFLAGS="-Wno-error=incompatible-pointer-types -Wno-incompatible-pointer-types" pip install --no-cache-dir --no-binary :all: pyjq'



COPY run config.test.json ${FLYWHEEL}/ 
COPY 	alohaCalculateAtrophyRates		\
	alohaDriver				\
	alohaFindSegmentationJson		\
	alohaFindCompletedJobs			\
	alohaT2NiftiJson			\
	alohaUpdateJobsJsonFile			\
						\
	/usr/local/bin/

COPY	alohaFindSegmentFiles.jq		\
	alohaFindT1T2.jq			\
	alohaFlattenDict.jq			\
	alohaJob2FileIds.jq			\
	alohaLib.jq				\
	alohaSessionReport.jq			\
	alohaSortSessions.jq			\
						\
	${FLYWHEEL}/

RUN cd ${FLYWHEEL}; git clone https://github.com/brainsciencecenter/flywheel.git; cd flywheel; git config pull.rebase false; git pull

RUN echo ':set mouse-=a' > /root/.vimrc

RUN chmod +x run
ENTRYPOINT ["./run -v"]


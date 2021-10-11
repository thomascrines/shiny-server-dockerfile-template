FROM openanalytics/r-base
 
LABEL maintainer="Name, Email address"
 
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
 
# system libraries of general use
RUN apt-get update && apt-get install -y \
    sudo \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev \
    libssl1.1
 
# system library dependency for the myappname app
RUN apt-get update && apt-get install -y \
    libmpfr-dev
 
# basic shiny functionality
RUN R -e "install.packages(c('shiny', 'rmarkdown'), repos='https://cloud.r-project.org/')"
 
# install dependencies of the myappname app
RUN R -e "install.packages('dygraphs', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('stringr', repos='https://cloud.r-project.org/')"
 
# copy the app to the image
RUN mkdir /root/<username>
RUN mkdir /root/<username/myappname
COPY myappname /root/<username>/myappname
 
EXPOSE 3838
 
CMD ["R", "-e", "shiny::runApp('/root/<username>/myappname',host='0.0.0.0',port=3838)"]

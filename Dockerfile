FROM makisyu/texlive-2019

RUN yum install -y pandoc python3-pip
RUN pip3 install pyyaml Jinja2

FROM registry.fedoraproject.org/fedora:35

RUN dnf update -y && \
dnf install -y iperf net-tools iptables iputils iproute-tc python3-pip && \
pip install tcconfig  && \
dnf clean all

CMD ["/bin/sh"]

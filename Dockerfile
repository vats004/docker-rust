# Use the official Ubuntu base image
FROM ubuntu:24.04

# Set the maintainer label
# LABEL maintainer="vatsalkeshav224@gmail.com"

# Update the package list and install necessary dependencies
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    git

# Download and install Rust using Rustup
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Source the environment variables to update the current shell session
RUN echo 'source $HOME/.cargo/env' >> /root/.bashrc

# Install the nightly version of Rust and the specified components
RUN /bin/bash -c "source $HOME/.cargo/env && rustup install nightly && rustup default nightly && \
    rustup component add cargo --toolchain nightly && \
    rustup component add clippy --toolchain nightly && \
    rustup component add llvm-tools-preview --toolchain nightly && \
    rustup component add rust-docs --toolchain nightly && \
    rustup component add rust-std --toolchain nightly && \
    rustup component add rustc --toolchain nightly && \
    rustup component add rustc-dev --toolchain nightly && \
    rustup component add rustfmt --toolchain nightly"

# Create a .gitconfig file with the provided user information
RUN git config --global user.name "vats004" \
    && git config --global user.email "vatsalkeshav224@gmail.com"

# Clone the rustfmt repository from GitHub
RUN git clone https://github.com/vats004/rustfmt.git /root/rustfmt
RUN git clone https://github.com/vats004/my-rustfmt.git /root/my-rustfmt

# Set the default command to bash
CMD ["/bin/bash"]
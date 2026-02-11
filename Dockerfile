# ==============================================================================
# Dockerfile for ModelSim on Ubuntu 20.04
# ==============================================================================
#
# COMMANDS TO USE THIS DOCKER IMAGE:
#
# 1. BUILD THE IMAGE:
#    docker build -t modelsim:latest .
#
# 2. RUN THE CONTAINER (Interactive with GUI support):
#    docker run -it --rm \
#      -e DISPLAY=$DISPLAY \
#      -v /tmp/.X11-unix:/tmp/.X11-unix \
#      -v $(pwd):/workspace \
#      --name modelsim-container \
#      modelsim:latest
#
#    Note: On host, run 'xhost +local:docker' first to allow X11 forwarding
#
# 3. RUN THE CONTAINER (Background/Detached):
#    docker run -d -it \
#      -v $(pwd):/workspace \
#      --name modelsim-container \
#      modelsim:latest
#
# 4. ENTER THE RUNNING CONTAINER:
#    docker exec -it modelsim-container bash
#
# 5. CREATE FILES IN CONTAINER:
#    # From inside container:
#    echo "module test(); endmodule" > /workspace/test.v
#    
#    # From host (container must be running):
#    docker exec -it modelsim-container bash -c "echo 'module test(); endmodule' > /workspace/test.v"
#
# 6. DOWNLOAD/COPY FILES FROM CONTAINER TO HOST:
#    docker cp modelsim-container:/path/in/container/file.txt ./local/path/
#
# 7. UPLOAD/COPY FILES FROM HOST TO CONTAINER:
#    docker cp ./local/file.txt modelsim-container:/path/in/container/
#
# 8. SAVE/COMMIT CONTAINER CHANGES TO NEW IMAGE:
#    docker commit modelsim-container modelsim:v1.0
#
# 9. TAG IMAGE FOR GITHUB CONTAINER REGISTRY (GHCR):
#    docker tag modelsim:latest ghcr.io/YOUR_GITHUB_USERNAME/modelsim:latest
#
# 10. LOGIN TO GHCR:
#     echo $GITHUB_TOKEN | docker login ghcr.io -u YOUR_GITHUB_USERNAME --password-stdin
#     
#     Note: Generate token at https://github.com/settings/tokens
#     Required scopes: write:packages, read:packages, delete:packages
#
# 11. PUSH IMAGE TO GHCR:
#     docker push ghcr.io/YOUR_GITHUB_USERNAME/modelsim:latest
#
# 12. PULL IMAGE FROM GHCR (on another machine):
#     docker pull ghcr.io/YOUR_GITHUB_USERNAME/modelsim:latest
#
# ==============================================================================

FROM ubuntu:20.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Set working directory
WORKDIR /workspace

RUN dpkg --add-architecture i386
# Update system and install dependencies required for ModelSim
RUN apt-get update && apt-get install -y \
    # Basic utilities
    wget \
    curl \
    vim \
    nano \
    git \
    unzip \
    # Required 32-bit libraries for ModelSim
    lib32gcc1 \
    libc6:i386 \
    libncurses5:i386 \
    libstdc++6:i386 \
    lib32z1 \
    libxft2:i386 \
    libxext6:i386 \
    # X11 libraries for GUI support
    libx11-6:i386 \
    libxrender1:i386 \
    libxtst6:i386 \
    libxi6:i386 \
    # Additional dependencies
    gcc \
    make \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Default command
CMD ["/bin/bash"]

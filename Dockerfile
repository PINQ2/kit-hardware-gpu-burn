ARG CUDA_VERSION=13.3.1
ARG IMAGE_DISTRO=ubuntu24.04
ARG COMPUTE=75

FROM nvidia/cuda:${CUDA_VERSION}-devel-${IMAGE_DISTRO} AS builder 

ARG COMPUTE=75

WORKDIR /build

COPY compare.cu gpu_burn-drv.cpp Makefile /build/

RUN make COMPUTE=${COMPUTE}

FROM nvidia/cuda:${CUDA_VERSION}-runtime-${IMAGE_DISTRO}

COPY --from=builder /build/gpu_burn /app/
COPY --from=builder /build/compare.fatbin /app/

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

WORKDIR /app

ENTRYPOINT ["./entrypoint.sh"]

---
title: Compiling Source Code on Spiedie
layout: default
images: []
tags: [GCC, CLANG, CMAKE, ICC, Intel Compilers]
description: Available compilers on spiedie for optimized compilations.
category: getting-started
prev: Spiedie Modules
---


### Table of Contents 

1. [GCC](#gcc)
2. [ICC](#intel)
	- [Runtime Libraries](#intel_libs)
3. [NVCC](#nvidia)
	- [Runtime Libraries](#nvidia_libs)

## <a name="compilers"></a> Compilers
### <a name="gcc"></a> GCC
The open source gcc and g++ compiler is available as a module and can be loaded with: 

```bash
module load gcc
```

### <a name="Intel"></a> ICC

Spiedie also provides users with the Intel Parallel Studio Compilers suite to take advantage of the improved performance on the Xeon-Phi architecture available. 

You can load the Intel compiler from the modules using: 

```bash
module load intel-compiler/
```

Additionally, you can include the cluster runtime library with:

```bash
module load intel-cluster-runtime/intel64/3.8 
```

This loads the following libraries:
- Intel Math Kernel LIbrary (Intel MKL&copy;)
- Intel Data Analytics Acceleration Library (Intel DAAL&copy;)
- Intel Integrated Performance Primitives
- Intel MPI library
- Intel Thread Building Block Library (Intel TBB&copy;)

<a href="https://software.intel.com/en-us/node/685016" target="_blank">Click here for the summary of the toolset</a>

### <a name="nvidia"></a> NVCC

The GPU compute nodes fully support CUDA accelerated applications and libraries. 

The CUDA toolkit and runtime libraries are also available as modules on spiedie. 

***Note: Multiple version of the CUDA toolkit is available from CUDA7 to CUDA10.1***


You can find all the available CUDA versions by running:

```bash
module avail | grep cuda
```

You can load the nvcc compiler using:
```bash
module load CUDA(version)/toolkit
```

Addtionally you can load the various runtime libraries such as: 

- CuBLAS:
```bash
module load CUDA(version)/blas 
```

- FFT:

```bash
module load CUDA(version)/fft 
```

- Nsight:

```bash
module load CUDA(version)/nsight 
```

- Profiler;

```bash
module load CUDA(version)/profiler 
```

<a href="https://developer.nvidia.com/gpu-accelerated-libraries" target="_blank"> Click here to learn more about NVidia's GPU accelerated libraries</a>
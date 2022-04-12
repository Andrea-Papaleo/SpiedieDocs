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

Spiedie offers a variety of node and hardware configurations in order to meet the many different needs of researchers. To best optimize your code, different compilers are available to load as modules.

### <a name="gcc"></a> GCC
The open source gcc and g++ compiler made by the Free Software Foundation Inc. They were originally written to be the compilers for the GNU operating system. They are capable of generating code for a large number of target architectures and is widely available on Unix-like platforms. To load the gcc module type

```bash
module load gcc
```

### <a name="Intel"></a> ICC

The Intel C++ compiler compiler is made by the Intel Corporation and is highly tuned for Intel processors. Intel C++ compiler features support for the latest C++ and OpenMP standards, as well as support for the latest Intel architectures. Intel C++ compiler is available free of charge for student and open source developers.

Spiedie also provides users with the Intel Parallel Studio Compilers suite to take advantage of the improved performance on the Xeon-Phi architecture available. 

Recently the Intel oneAPI core elements have been added to the cluster. The stated goal of the oneAPI specification is to enable an open, industry standard, cross-architecture software stack for accelerators. You can find out more <a href="https://www.oneapi.io/" target="_blank">here</a>.

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

<a href="https://software.intel.com/en-us/node/685016" target="_blank">Click here for the summary of the tool-set</a>

### <a name="nvidia"></a> NVCC

The GPU compute nodes fully support CUDA accelerated applications and libraries. 

The CUDA toolkit and runtime libraries are also available as modules on spiedie. 

***Note: Multiple version of the CUDA toolkit is available from CUDA7 to CUDA11.3***


You can find all the available CUDA versions by running:

```bash
module avail | grep cuda
```

You can load the nvcc compiler using:
```bash
module load CUDA(version)/toolkit
```

Addtionally you can load the various runtime libraries such as: 

CuBLAS:
```bash
module load CUDA(version)/blas 
```

FFT:

```bash
module load CUDA(version)/fft 
```

Nsight:

```bash
module load CUDA(version)/nsight 
```

Profiler;

```bash
module load CUDA(version)/profiler 
```

<a href="https://developer.nvidia.com/gpu-accelerated-libraries" target="_blank"> Click here to learn more about NVidia's GPU accelerated libraries</a>
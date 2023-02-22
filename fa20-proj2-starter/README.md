# fa20-proj2-starter

```
.
├── inputs (test inputs)
├── outputs (some test outputs)
├── README.md
├── src
│   ├── argmax.s (partA)
│   ├── classify.s (partB)
│   ├── dot.s (partA)
│   ├── main.s (do not modify)
│   ├── matmul.s (partA)
│   ├── read_matrix.s (partB)
│   ├── relu.s (partA)
│   ├── utils.s (do not modify)
│   └── write_matrix.s (partB)
├── tools
│   ├── convert.py (convert matrix files for partB)
│   └── venus.jar (RISC-V simulator)
└── unittests
    ├── assembly (contains outputs from unittests.py)
    ├── framework.py (do not modify)
    └── unittests.py (partA + partB)
```

这个项目不会去从头训练一个神经网络（训练过程），而是会直接使用一个预训练好的模型来执行MNIST手写数字识别任务（推理过程）。

## Materials
[Stride of an array](https://en.wikipedia.org/wiki/Stride_of_an_array)
* An array with stride of exactly the same size as the size of each of its elements is contiguous in memory. Such arrays are sometimes said to have unit stride. Unit stride arrays are sometimes more efficient than non-unit stride arrays, but non-unit stride arrays can be more efficient for 2D or multi-dimensional arrays, depending on the effects of caching and the access patterns used.



## Here's what I did in project 2:

# FIFO
First In First Out (FIFO) is a very popular and useful design block for purpose of synchronization and a handshaking mechanism between the modules. 
## FIFO types
1. Synchronous FIFO.
2. Asynchronous FIFO.
   
In a Synchronous FIFO, the write and read to the FIFO happen on a single clock. This means in Synchronous FIFO, either write or read can happen at a single time (on single clock) while in the case of an Asynchronous FIFO, read and write can happen simultaneously (Separate clocks for write and read).

## Synchronous FIFO Block Diagram
![image](https://github.com/UserImages/user_images/blob/main/fifo.PNG)
| Signal   |    Description                 | Direction|
|----------|--------------------------------|----------|
| clk      | system clock                   | input    | 
| rst      | active high synchronous reset  | input    | 
| data_in  | write data                     | input    | 
| wr_en    | write enable                   | input    | 
| rd_en    | read enable                    | input    |
| data_out | read data                      | output   |
| full     | FIFO is full                   | output   |
| empty    | FIFO is empty                  | output   |

## Synchronous FIFO Operation
### 1. FIFO write operation
FIFO can write the `data_in` at every posedge of the `clock` based on `wr_e`n signal till it is `full`. The write pointer gets incremented on every data write in FIFO memory.

### 2. FIFO read operation
The data can be taken out or read from FIFO at every posedge of the `clock` based on the `rd_en` signal till it is `empty`. The read pointer gets incremented on every data read from FIFO memory.

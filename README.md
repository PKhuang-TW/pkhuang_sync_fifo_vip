# 📘 Sync FIFO UVM VIP Description

## 🧩 Module Overview

This VIP module implements a synchronous FIFO with blocking read and write logic. It supports a complete UVM verification environment including randomized sequences and functional coverage collection. The FIFO supports parameterizable depth and data width, and automatically handles full and empty conditions to ensure correct data flow.

This VIP supports the following features:

- Write data (when FIFO is not full)
- Read data (when FIFO is not empty)
- Full and empty status indicators
- Random/continuous/idle test scenarios

---

## 🔧 I/O Ports

| Port    | Direction | Width        | Description                          |
|---------|-----------|--------------|--------------------------------------|
| `clk`   | Input     | 1            | Clock signal, rising-edge triggered  |
| `rst_n` | Input     | 1            | Active-low asynchronous reset        |
| `wr_en` | Input     | 1            | Write enable                         |
| `rd_en` | Input     | 1            | Read enable                          |
| `din`   | Input     | `DATA_WIDTH` | Data input                           |
| `dout`  | Output    | `DATA_WIDTH` | Data output                          |
| `full`  | Output    | 1            | FIFO is full                         |
| `empty` | Output    | 1            | FIFO is empty                        |

---

## 🔁 FIFO Behavior

- **Reset Behavior**:
  - When `rst_n` is deasserted (`0`), the FIFO buffer is cleared and `full` is set to `0`, `empty` to `1`.

- **Write Operation**:
  - When `wr_en` is `1` and the FIFO is not full (`full == 0`), data is written from `din`.

- **Read Operation**:
  - When `rd_en` is `1` and the FIFO is not empty (`empty == 0`), data is read to `dout`.

- **Full and Empty Transitions**:
  - After writing to full capacity, `full` is set to `1`, and further writes are blocked.
  - After reading all data, `empty` is set to `1`, and further reads are blocked.

---

## 📁 Directory Structure

sync_fifo_uvm_vip/
├── design/
│   └── rtl.v
│
├── cov/
│   └── fifo_coverage.sv
│
├── tb/
│   └── tb_top.sv
│
├── seq/
│   ├── rand_read_write_seq.sv
│   ├── full_write_seq.sv
│   └── empty_read_seq.sv
│
├── src/
│   ├── fifo_env.sv
│   ├── fifo_agent.sv
│   ├── fifo_driver.sv
│   ├── fifo_monitor.sv
│   ├── fifo_seq_item.sv
│   ├── fifo_interface.sv
│   ├── fifo_package.sv
│   └── fifo_config.sv
│
├── scb/
│   └── fifo_scoreboard.sv
│
└── test/
    ├── fifo_test_base.sv
    ├── full_write_test.sv
    ├── empty_read_test.sv
    └── rand_read_write_test.sv

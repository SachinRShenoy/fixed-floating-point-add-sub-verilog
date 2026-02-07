# Fixed and Floating Point Addition and Subtraction (Verilog HDL)

This repository contains the Verilog HDL implementation of a **Fixed-point and Floating-point Addition/Subtraction unit**, designed and verified on the **DE2-115 FPGA development board** using **Intel Quartus Prime**.

The project demonstrates:
- Q8.8 fixed-point arithmetic
- IEEE-754 single-precision floating-point conversion
- Floating-point addition and subtraction
- FPGA-based output visualisation using 7-segment displays

---

## 🔧 Features

- 16-bit signed fixed-point inputs (Q8.8 format)
- IEEE-754 single-precision floating-point conversion
- Floating-point addition and subtraction (normalized numbers only)
- Fixed-point addition and subtraction
- Mode selection between FIXED and FLOAT operations
- Modular, synthesizable Verilog design
- FPGA-ready top module with switch and push-button control

---

## 🧠 Supported Operations

| Mode | Operation | Description |
|----|----|----|
| Fixed | ADD | Q8.8 fixed-point addition |
| Fixed | SUB | Q8.8 fixed-point subtraction |
| Floating | ADD | IEEE-754 single-precision addition |
| Floating | SUB | IEEE-754 single-precision subtraction |

---

## 🏗️ Project Structure
```
├── rtl/
│   ├── hex7seg.v
│   ├── Fixed_Add_Sub.v
│   ├── Fixed_to_IEEE754.v
│   ├── Float_Add.v
│   ├── Float_Sub.v
│   └── FPGA_Fixed_Float_AddSub.v
│
├── sim/
│   └── tb_FPGA_Fixed_Float_AddSub.v
│
├── quartus/
│   ├── Fixed_floating.qpf
│   └── Fixed_floating.qsf
│
├── docs/
│   └── HDL_Report.pdf
│
└── README.md
```
---

## 🖥️ FPGA Platform Details

- **Board:** DE2-115 Development and Education Board  
- **FPGA:** Intel Cyclone IV E (EP4CE115F29C7)  
- **Technology:** 60 nm CMOS  
- **Clock:** 50 MHz on-board oscillator  

---

## 🎛️ Control Mapping (FPGA)

| Control | Function |
|------|--------|
| SW[2] | Mode select (0 = Fixed, 1 = Floating) |
| KEY0 | Floating-point ADD (active-low) |
| KEY1 | Floating-point SUB (active-low) |
| HEX Displays | Output shown in hexadecimal |

---

## 🧪 Simulation

Simulation is performed using **ModelSim – Intel FPGA Edition**.

### Steps:
```tcl
vlib work
vlog rtl/*.v
vlog sim/tb_FPGA_Fixed_Float_AddSub.v
vsim work.tb_FPGA_Fixed_Float_AddSub
run -all


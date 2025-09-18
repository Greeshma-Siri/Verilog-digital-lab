# Basic Logic Gates in Verilog

This folder contains Verilog implementations of basic logic gates and universal gates.
The design and the testbench are embedded together for each gate

## List of Gates
- **AND Gate** – `and_gate.v`
- **OR Gate** – `or_gate.v`
- **NOT Gate** – `not_gate.v`
- **NAND Gate** – `nand_gate.v`
- **NOR Gate** – `nor_gate.v`

Each gate is implemented using **dataflow modeling** with the `assign` statement.

---

## Example: AND Gate

### Truth Table

| A | B | Y |
|---|---|---|
| 0 | 0 | 0 |
| 0 | 1 | 0 |
| 1 | 0 | 0 |
| 1 | 1 | 1 |

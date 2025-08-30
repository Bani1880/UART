# UART
VLSI Implementation of a UART Module
This project implements a Universal Asynchronous Receiver/Transmitter (UART) module in VLSI, designed to facilitate reliable serial data communication between digital devices. The implementation uses the Verilog Hardware Description Language (HDL) and is synthesised and simulated using Vivado. The project focuses on creating a robust, asynchronous, full-duplex communication interface suitable for a wide range of embedded systems and applications.

Working Principle

UART is a serial communication protocol that sends data one bit at a time over a single line. The transmitter (TX) and receiver (RX) lines are crossed, connecting the transmitter of one device to the receiver of the other, and vice versa.The communication is asynchronous and relies on a specific data packet 

structure:

Start Bit: A low signal (logic 0) that indicates the beginning of a data transfer.

Data Bits: The actual data, typically 5 to 9 bits, sent from the Least Significant Bit (LSB) to the Most Significant Bit (MSB).

Parity Bit (Optional): A bit used for simple error checking.

Stop Bit(s): One or two high signals (logic 1) that mark the end of the data packet.

The two devices must agree on a baud rate, which determines the speed of the data transfer, to ensure accurate timing.

Project Structure:

uart_tx.v: Verilog module for the UART transmitter.

uart_rx.v: Verilog module for the UART receiver.

uart_tb.v: Testbench file for simulating the UART module.

VLSI Implementation of a UART Module.docx: Original documentation of the project.

schematic.png: Synthesized schematic of the UART module.

simulation.png: Waveform simulation results.

Building and Simulation:

Open Vivado and create a new project.
Add uart_tx.v and uart_rx.v as design sources.
Add uart_tb.v as a simulation source.
Run the behavioral simulation to verify the functionality.
If you are targeting a specific FPGA, you can run synthesis and implementation on the uart_tx and uart_rx modules.

Testbench Details:

The provided testbench (uart_tb.v) simulates a full transmit-receive cycle.
It initializes the system with a reset.
It sets the tx_data to 8'hAB.
It starts the transmission by setting tx_start to 1.
It waits for the rx_ready signal to be high, indicating that data has been received.
Finally, it displays the received data to confirm successful transmission.
The simulation waveform confirms that the transmitted data (8'hAB) is correctly received.

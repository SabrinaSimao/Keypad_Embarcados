/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include <stdio.h>
#include <stdint.h>
#include <system.h>

void Keypad_init();
void Keypad_config(char enable, char clear, char reset);        // Configura o periférico
void Keypad_halt();          // Desativa o periférico
//int Keypad_en_irq();        // Habilita interrupção
//int Keypad_disable_irq();   // Desabilita interrupção
uint32_t Keypad_read_buffer();    // read data xxxx from device
//int Keypad_write_xxxxx();
void Keypad_clr();

uint32_t *p_key = (uint32_t *)KEYPAD_0_BASE;

void Keypad_init(){
	*(p_key+0) = 1<<31|0<<7|0<<0;

}

void Keypad_config(char enable, char clear, char reset){
	*(p_key+0) = enable<<31|clear<<7|reset<<0;
}

void Keypad_halt(){
	*(p_key+0) = 0<<31|1<<7|0<<0;
}

uint32_t Keypad_read_buffer(){

	uint32_t buffer = *(p_key+1);
	return buffer;
}

void Keypad_clr(){
	*(p_key+0) = 1<<31|1<<7|0<<0;

}

int main(){

  printf("Hello from Nios II!\n");

  Keypad_init();

  printf("Keypad INIT\n");

  while(1){
	  int buff = Keypad_read_buffer();
	  printf("Read: %04x \n", buff);

	  usleep(100000);

  }

  return 0;
}

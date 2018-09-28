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
#include <system.h>

void Keypad_init();
void Keypad_config(char enable, char clear, char reset);        // Configura o periférico
void Keypad_halt();          // Desativa o periférico
//int Keypad_en_irq();        // Habilita interrupção
//int Keypad_disable_irq();   // Desabilita interrupção
int Keypad_read_buffer();    // read data xxxx from device
//int Keypad_write_xxxxx();

int *p_key = (int *)KEYPAD_0_BASE;
int buffer;

void Keypad_init(){
	*(p_key+0) = 1<<31|0<<7|0<<0;

}

void Keypad_config(char enable, char clear, char reset){
	*(p_key+0) = enable<<31|clear<<7|reset<<0;
}

void Keypad_halt(){
	*(p_key+0) = 0<<31|1<<7|0<<0;
}

int Keypad_read_buffer(){
	buffer = *(p_key+1);
	return buffer;
}



int main(){

  Keypad_init();

  printf("Hello from Nios II!\n");
  while(1){
	  Keypad_read_buffer();
	  printf("Read \n= %d", buffer);
	  usleep(50000);

  }

  return 0;
}

import std.array;
import std.algorithm;
import std.range;
import std.stdio;

class Node {
	int v;
	Node next;

	this(int v) {
		this.v = v;
	}
}

Node[1000001] nodes;
void main() {
	int[] input = [7, 8, 4, 2, 3, 5, 9, 1, 6];
	Node start = new Node(input[0]);
	Node last = start;
	nodes[input[0]] = start;
	for (int i = 1; i < input.length; i++) {
		Node n = new Node(input[i]);
		nodes[input[i]] = n;
		last.next = n;
		last = n;
	}
	for (int i = 10; i <= 1000000; i++) {
		Node n = new Node(i);
		nodes[i] = n;
		last.next = n;
		last = n;
	}
	last.next = start;
	Node current = start;
	for (int move = 0; move < 10000000; move++) {
		Node hold = current.next;
		current.next = current.next.next.next.next;
		int search = current.v - 1;
		if (search <= 0) {
			search = 1000000;
		}
		while (hold.v == search || hold.next.v == search || hold.next.next.v == search) {
			search--;
			if (search <= 0) {
				search = 1000000;
			}
		}
		Node dest = nodes[search];
		Node h = dest.next;
		dest.next = hold;
		hold.next.next.next = h;
		current = current.next;
	}
	ulong total = nodes[1].next.v;
	total *= nodes[1].next.next.v;
	writeln(total);
}

module app;

import std.conv;
import std.file;
import std.stdio;
import std.string;

bool[int] visited;

void main() {
	string input = cast(string) read("../input.txt");
	string[] lines = input.split("\n")[0..$ - 1];
	int acc = 0;
	int i = 0;
	while (i !in visited) {
		string[] parts = lines[i].split(" ");
		int v = parts[1].to!int;
		visited[i] = true;
		if (parts[0] == "acc") {
			acc += v;
		} else if (parts[0] == "jmp") {
			int l = tryToFinish(lines, acc, i + 1);
			if (l != 0) {
				acc = l;
				break;
			}
			i += v;
			continue;
		} else if (parts[0] == "nop") {
			int l = tryToFinish(lines, acc, i + v);
			if (l != 0) {
				acc = l;
				break;
			}
		}
		i++;
	}
	writeln(acc);
}

int tryToFinish(string[] lines, int acc, int i) {
	bool[int] localVisited;
	while (i !in localVisited) {
		if (i == lines.length) return acc;
		string[] parts = lines[i].split(" ");
		int v = parts[1].to!int;
		localVisited[i] = true;
		if (parts[0] == "acc") {
			acc += v;
		} else if (parts[0] == "jmp") {
			i += v;
			continue;
		}
		i++;
	}
	return 0;
}

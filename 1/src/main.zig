const std = @import("std");

const input = @embedFile("input");

// Dont mind these war crimes
const line_offset = 14;
const num_lines = 1000;

var left_nums: [1000]u32 = undefined;
var right_nums: [1000]u32 = undefined;

var total_distance: u32 = 0;

pub fn main() !void {
    std.debug.assert(input.len == num_lines * line_offset);
    // Parse nums
    for (0..num_lines) |index| {
        left_nums[index] = try std.fmt.parseInt(u32, input[index * line_offset .. index * line_offset + 5], 10);
        right_nums[index] = try std.fmt.parseInt(u32, input[index * line_offset + 8 .. index * line_offset + 13], 10);
    }

    // Sort nums
    std.mem.sort(u32, &left_nums, {}, comptime std.sort.asc(u32));
    std.mem.sort(u32, &right_nums, {}, comptime std.sort.asc(u32));

    for (left_nums, right_nums) |left_num, right_num| {
        if (left_num > right_num) {
            total_distance += left_num - right_num;
        } else {
            total_distance += right_num - left_num;
        }
    }
    std.debug.print("{}", .{total_distance});
}

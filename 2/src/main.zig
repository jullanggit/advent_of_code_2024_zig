const std = @import("std");

const input = @embedFile("input");

const splitScalar = std.mem.splitScalar;

const Order = enum {
    Ascending,
    Descending,
    Undefined,
};

fn part_1() !void {
    var lines = splitScalar(u8, input[0 .. input.len - 1], '\n');

    var safe_reports: u128 = 0;

    while (lines.next()) |line| {
        var str_nums = splitScalar(u8, line, ' ');

        var nums: [8]u8 = undefined;
        var index: usize = 0;
        while (str_nums.next()) |str_num| {
            nums[index] = try std.fmt.parseInt(u8, str_num, 10);
            index += 1;
        }

        var order = Order.Undefined;
        var safe = true;
        for (nums[0 .. index - 1], nums[1..index]) |last_num, num| {
            switch (std.math.order(num, last_num)) {
                .eq => {
                    safe = false;
                    break;
                },
                .lt => {
                    if (last_num - num > 3 or order == Order.Ascending) {
                        safe = false;
                        break;
                    }
                    if (order == Order.Undefined) {
                        order = Order.Descending;
                    }
                },
                .gt => {
                    if (num - last_num > 3 or order == Order.Descending) {
                        safe = false;
                        break;
                    }
                    if (order == Order.Undefined) {
                        order = Order.Ascending;
                    }
                },
            }
        }
        safe_reports += @intFromBool(safe);
    }
    std.debug.print("{}", .{safe_reports});
}

pub fn main() !void {
    try part_1();
}

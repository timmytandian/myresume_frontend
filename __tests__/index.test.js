test("Sanity check", () => {
    expect(true).toBe(true);
});

import { getVisitorCount } from "../index.js";

global.fetch = jest.fn(() =>
    Promise.resolve({
        json: () => Promise.resolve({ body: "229" })
    })
);

beforeEach(() => {
    fetch.mockClear();
});
  

it("get visitor count", async () => {
    const rate = await getVisitorCount();

    expect(rate).toEqual(1.42);
    expect(fetch).toHaveBeenCalledTimes(1);
});
/**
 * @jest-environment jsdom
 */

import { getVisitorCount } from "../js/index.js";

global.fetch = jest.fn(() =>
    Promise.resolve({
        json: () => Promise.resolve({ body: 229 })
    })
);

beforeEach(() => {
    fetch.mockClear();
});
  

it("get visitor count", async () => {
    const visitorCount = await getVisitorCount();

    expect(visitorCount).toEqual(229);
    expect(fetch).toHaveBeenCalledTimes(1);
});
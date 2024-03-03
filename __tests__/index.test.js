/**
 * @jest-environment jsdom
 */

import 'isomorphic-fetch'; // fetch API may not be implemented yet in the test environment, so import this
import { getVisitorCount } from "../src/js/index.js";

// This is the section where we mock `fetch` API
const fetchMock = jest
	.spyOn(global, 'fetch')
	.mockImplementation(() => 
        Promise.resolve({ 
            json: () => Promise.resolve(229),
            ok: true
        }));


// This is actual testing suite
describe('index.js testing', () => {
	test('getVisitorCount function', async () => {
		const visitorCount = await getVisitorCount(); // getVisitorCount contains fetch API
        
        expect(visitorCount).toEqual(229);
		expect(fetchMock).toHaveBeenCalledTimes(1);
        
        const fetchMockUrl = fetchMock.mock.calls[0][0].href;
        expect(fetchMockUrl).toBe("https://3ijz5acnoe.execute-api.ap-northeast-1.amazonaws.com/dev/counts/6632d5b4-5655-4c48-b7b6-071d5823c888?func=addOneVisitorCount");
	});
});
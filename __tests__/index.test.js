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
        expect(fetchMockUrl).toBe("https://vo422t3t39.execute-api.ap-northeast-1.amazonaws.com/counts/250808e1-38f9-2c29-90b9-5146319be0c3?func=addOneVisitorCount");
	});
});
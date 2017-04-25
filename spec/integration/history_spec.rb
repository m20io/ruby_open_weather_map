describe 'History weather information' do
  let(:options) do
    { units: 'metric', start: Date.new(2017,04,1), APPID: '1111111111' }
  end

  describe 'searching by city' do
    context 'when the city is found' do
      let(:weather) do
        VCR.use_cassette('integration/history_by_city') do
          OpenWeather::History.city('Berlin,DE', options)
        end
      end

      it 'returns results' do
        expect(weather).to include('list')
      end
    end

    context 'when the city is not found' do
      let(:weather) do
        VCR.use_cassette('integration/history_not_found_city') do
          OpenWeather::History.city('Not a city,DE', options)
        end
      end

      it 'returns an attribute with code 404' do
        expect(weather['cod']).to eq('404')
      end
    end
  end

end

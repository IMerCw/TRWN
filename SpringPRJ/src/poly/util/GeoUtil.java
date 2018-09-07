package poly.util;

import java.io.IOException;

import com.google.code.geocoder.Geocoder;
import com.google.code.geocoder.GeocoderRequestBuilder;
import com.google.code.geocoder.model.GeocodeResponse;
import com.google.code.geocoder.model.GeocoderRequest;
import com.google.code.geocoder.model.GeocoderResult;
import com.google.code.geocoder.model.GeocoderStatus;
import com.google.code.geocoder.model.LatLng;

public class GeoUtil {
	public static double[] addrToLatLon(String address) throws Exception {

		if (address == null)  
			return null;
		
			Geocoder geocoder = new Geocoder();
			// setAddress : 변환하려는 주소 (경기도 성남시 분당구 등)
			// setLanguate : 인코딩 설정
			GeocoderRequest geocoderRequest = new GeocoderRequestBuilder().setAddress(address).setLanguage("ko").getGeocoderRequest();
			GeocodeResponse geocoderResponse;

			try {

			geocoderResponse = geocoder.geocode(geocoderRequest);

			if (geocoderResponse.getStatus() == GeocoderStatus.OK & !geocoderResponse.getResults().isEmpty()) {


			GeocoderResult geocoderResult=geocoderResponse.getResults().iterator().next();

			LatLng latitudeLongitude = geocoderResult.getGeometry().getLocation();
				
							  

			double[] coords = new double[2];

			coords[0] = latitudeLongitude.getLat().doubleValue();
			coords[1] = latitudeLongitude.getLng().doubleValue();

			return coords;

			}

			} catch (IOException ex) {

			ex.printStackTrace();

			}

			return null;

			}


	}


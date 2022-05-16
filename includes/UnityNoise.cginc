#ifndef UNITY_NOISE
#define UNITY_NOISE


float mod289(float x) {
	return x - floor(x ) * 289.0;
}

float2 mod289(float2 x) {
	return x - floor(x ) * 289.0;
}

float3 mod289(float3 x) {
	return x - floor(x) * 289.0;
}

float4 mod289(float4 x) {
	return x - floor(x ) * 289.0;
}




#endif
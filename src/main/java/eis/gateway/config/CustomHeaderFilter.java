package eis.gateway.config;

import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import reactor.core.publisher.Mono;

@Configuration
public class CustomHeaderFilter {

    @Bean
    public GlobalFilter removeDuplicateAccessControlAllowOriginHeader() {
        return (exchange, chain) -> chain.filter(exchange).then(Mono.fromRunnable(() -> {
            exchange.getResponse().getHeaders().remove("Access-Control-Allow-Origin");
        }));
    }
}
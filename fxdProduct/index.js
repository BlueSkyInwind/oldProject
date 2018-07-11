import React from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    View
} from 'react-native';

class FirstView extends React.Component {
    render() {
        var contents = this.props.rootTag;
        return (
                <View style={styles.center}>
                <Text >
                {this.props.content}
                </Text>
                </View>
                );
    }
}

const styles = StyleSheet.create({
                                 center: {
                                 marginTop: 50,
                                 width:120,
                                 height: 60,
                                 justifyContent: 'center',
                                 alignItems: 'center',
                                 backgroundColor:"red"
                                 },
                                 });

// 整体js模块的名称
AppRegistry.registerComponent('FirstView', () => FirstView);

